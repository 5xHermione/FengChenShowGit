class DiffPullRequest
  attr_accessor :base_branch, :compare_branch
  attr_reader :repo 

  def initialize(repo_path, opts = {})
    @repo = repo_path

    @base_branch = opts[:base_branch] if opts[:base_branch]
    @compare_branch = opts[:compare_branch] if opts[:compare_branch]

    @commit_parent_obj = Git.open(@repo).gcommit(opts[:sha]).parent if opts[:sha]
    @commit_obj = Git.open(@repo).gcommit(opts[:sha]) if opts[:sha]

    changed_file_name
  end

  def all_branch
    %x`git -C #{@repo} branch --list`.split("\n")
  end

  def changed_file_name
    if @base_branch.present?
      @changed_file_name = %x`git -C #{@repo} diff --name-only #{@compare_branch} #{@base_branch}`.split("\n")
    else
      @changed_file_name = %x`git -C #{@repo} diff --name-only #{@commit_parent_obj.sha} #{@commit_obj.sha}`.split("\n")
    end
  end

  def diff_in_file(file_name)
    #compare branch first, base branch after
    if @base_branch.present?
      file = %x`git -C #{@repo} diff #{@base_branch}..#{@compare_branch} -- #{file_name}`.split("\n")
    else
      file = %x`git -C #{@repo} diff #{@commit_parent_obj.sha}..#{@commit_obj.sha} -- #{file_name}`.split("\n")
    end
    diff = { "code" => {} }
    #file name
    diff["file_name"] = file[0].match(/^diff --git a\/(.+)\s/)[1]
    #mode
    if file[1].match(/^deleted file mode /)
      diff["mode"] = "delete"
      file.shift(5)
    elsif file[1].match(/^new file mode /)
      diff["mode"] = "new"
      file.shift(5)
    else
      diff["mode"] = "modify"
      file.shift(4)
    end
    #code
    block = ""
    if file != []
      file.each do |f|
        if f.match(/^@@ (.+) @@/)
          diff["code"][f] = []
          block = f
        else
          if f.match(/^\+/)
            diff["code"][block] << ["add", f]
          elsif f.match(/^\-/)
            diff["code"][block] << ["del", f]
          else
            diff["code"][block] << ["org", f]
          end
        end
      end
    end
    diff
  end

  def diff_in_files
    diffs = []
    @changed_file_name.each do |file|
      diffs << diff_in_file(file)
    end
    diffs
  end
end
