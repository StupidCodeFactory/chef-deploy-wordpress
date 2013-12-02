require 'chefspec'

describe 'lintest_apache2::default' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe)}

  it 'installs the apache2 package' do
    expect(chef_run).to install_package('apache2')
  end

  describe 'Creates apache2 configuration file' do
    describe 'With the correct paths' do
      it 'for the log file' do
        expect(chef_run).to render_file('/etc/apache2/apache2.conf').
          with_content(/ErrorLog\s+\/var\/log\/apache2\/error\.log/).
          with_content(/StartServers\s+4/).
          with_content(/MinSpareServers\s+4/).
          with_content(/MiaxSpareServers\s+8/).
          with_content(/Serverlimit\s+128/).
          with_content(/MaxClient\s+48/).
          with_content(/MaxRequestsPerChild\s+500/)
      end
    end
  end

  describe "Wordpress site" do
    it "creates the virtual host files" do
      expect(chef_run).to render_file('/etc/apache2/sites-available/wordpress.conf').
        with_content(/VirtualHost\s+\*:80/).
        with_content(/ServerAlias\s+cms-deploy-test-lin lin-test.rackstage.co.uk/).
        with_content('DocumentRoot /var/www/vhosts/lin-test.rackstage.co.uk/public_html').
        with_content('ErrorLog /var/log/apache2/wordpress-error.log').
        with_content('CustomLog /var/log/apache2/wordpress-access.log combined').
        with_content('ErrorLog /var/log/apache2/wordpress-error.log').
        with_content('CustomLog /var/log/apache2/wordpress-access.log').
        with_content('RewriteLog /var/log/apache2/wordpress-rewrite.log')

    end
  end
end
