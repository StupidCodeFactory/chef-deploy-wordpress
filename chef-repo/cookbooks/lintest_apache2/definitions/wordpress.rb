

define :wordpress, :variables => {} do

  src_filename = 'latest.tar.gz'
  src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"

  remote_file params[:name] do
    source "http://wordpress.org/#{src_filename}"
    path src_filepath
  end

  bash "untar #{params[:name]}" do
    user 'root'
    cwd ::File.dirname(src_filepath)
    code "tar -zxf #{src_filename}  && mv wordpress #{params[:docroot]}"
    not_if do
      Dir.exists?(params[:docroot])
    end
  end

  params.merge!(secret_keys: WordpressHelper.fetch_secret_keys)

  template "#{params[:docroot]}/wp-config.php" do
    mode 0644
    variables params[:variables]
    backup false
  end

  bash "create wordpress database" do
    code "mysqladmin create #{params[:mysql_dbname]}"
    not_if do
      Dir.exists?(params[:docroot])
    end
  end

  template "/tmp/grant.sql" do
  end

  bash "grant user access database" do
    code "mysqladmin create #{params[:mysql_dbname]}"
    not_if do
      Dir.exists?(params[:docroot])
    end
  end

end
