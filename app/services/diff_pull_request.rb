class DiffPullRequest
  def initialize(repo_path)
    @repo = repo_path
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
    %x`git -C #{@repo} diff --name-only #{@compare_branch} #{@base_branch}`.split("\n")
  end

  def diff_in_files(file_name)
    #compare branch first, base branch after
    arr = []
    files = %x`git -C #{@repo} diff #{@compare_branch} #{@base_branch} -- #{file_name}`.split("\n")
    files.each do |s|
      if s.match(/^diff/)
        arr << "file name"
      elsif s.match(/^index/)
        arr << "index"
      elsif s.match(/^\-\-\- /) || s.match(/^\+\+\+ /)
        arr << ""
      elsif s.match(/^@@ /)
        arr << "line"
      elsif s.match(/^\s/)
        arr << "origin code"
      elsif s.match(/^\+ /)
        arr << "addition"
      elsif s.match(/^\- /) 
        arr << "deletion"
      else
        arr << ""
      end
    end
    @diff = Hash[*([arr, files].transpose.flatten)]
  end
  @diff
end
