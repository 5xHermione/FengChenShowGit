  attr_accessor :base_branch, :compare_branch
  attr_reader :repo 

    @base_branch = opts[:base_branch] if opts[:base_branch]
    @compare_branch = opts[:compare_branch] if opts[:compare_branch]
    @commit_parent_obj = Git.open(@repo).gcommit(opts[:sha]).parent if opts[:sha]
    @commit_obj = Git.open(@repo).gcommit(opts[:sha]) if opts[:sha]
    changed_file_name
    if @base_branch.present?
      @changed_file_name = %x`git -C #{@repo} diff --name-only #{@compare_branch} #{@base_branch}`.split("\n")
    else
      @changed_file_name = %x`git -C #{@repo} diff --name-only #{@commit_parent_obj.sha} #{@commit_obj.sha}`.split("\n")
    end
    if @base_branch.present?
      file = %x`git -C #{@repo} diff #{@base_branch}..#{@compare_branch} -- #{file_name}`.split("\n")
    else
      file = %x`git -C #{@repo} diff #{@commit_parent_obj.sha}..#{@commit_obj.sha} -- #{file_name}`.split("\n")
    end