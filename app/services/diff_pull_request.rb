class DiffPullRequest
  def initialize(repo_path, opts = {})
    @repo = repo_path
    set_base_branch(opts[:base_branch]) if opts[:base_branch]
    set_compare_branch(opts[:compare_branch]) if opts[:compare_branch]
    changed_file_name
  end

  def set_base_branch(br)
    @base_branch = br
  end

  def set_compare_branch(br)
    @compare_branch = br
  end

  def repo
    @repo
  end

  def base_branch
    @base_branch
  end

  def compare_branch
    @compare_branch
  end

  def all_branch
    %x`git -C #{@repo} branch --list`.split("\n")
  end

  def changed_file_name
    @changed_file_name = %x`git -C #{@repo} diff --name-only #{@compare_branch} #{@base_branch}`.split("\n")
  end

  def diff_in_file(file_name)
    #compare branch first, base branch after
    file = %x`git -C #{@repo} diff #{@base_branch}..#{@compare_branch} -- #{file_name}`.split("\n")
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
