require 'nbmd_ps/cli/base'
require 'nbmd_ps/commands/init'

module NbmdPs
  module CLI
    # 'generate' command module.
    # Creating new Schema files
    module Init
      extend CLI::Base

      # Returns a OptionParser for parsing 'generate' command options.
      #
      # @param (see NbmdPs::CLI::Base#make_parser)
      # @return (see NbmdPs::CLI::Base#make_parser)
      def self.make_parser(options = {})
        binname = options.fetch(:bin, 'nbmd_ps')

        OptionParser.new do |opts|
          opts.banner = "#{binname} init [options] <project name or path>"
          opts.on('-y', '--yaml', 'Generate metafile in YAML format') do |y|
            yield :yaml, y
          end
          opts.on('-l', '--level 2', 'Supplier API Level: 1 (no automation) to 3 (full automation). Default: 3') do |y|
            yield :level, y
          end
        end
      end

      # Executes the 'generate' command.
      #
      # @example Usage
      #   NbmdPs::CLI::Generate.execute(argv: ['bread'],
      #                               output_file: 'schema/schemata/bread.json')
      #
      # @param (see NbmdPs::CLI::Base#execute)
      # @return (see NbmdPs::CLI::Base#execute)
      def self.execute(options = {})
        name = options.fetch(:argv).join(' ')
        abort("No project or company name supplied") unless name.present?
        
        # Default values
        options[:level] = options[:level] ? options[:level].to_i : 3
        
        # Flag the project as not new by default
        # Will be flagged as true if no schemata folder
        new_project = false
        
        # Get the name and project path
        if name =~ /(\.+\/?|\/)/
          project_path = File.expand_path(name)
          safename = File.basename(project_path)
          name = safename.titleize
        else
          safename = name.parameterize
          project_path = File.expand_path(safename)
        end
        
        notify "\n"
        notify "Creating project: #{name}"
        
        # Prepare project folder
        resource = safename
        path = project_path
        if File.directory?(path)
          notify(resource, "Directory already exists - No action", :warning)
        else
          FileUtils.mkdir_p path
          notify(resource, "Project directory created", :success)
        end
        
        # Write meta.json
        res_name = "meta.#{options[:yaml] ? 'yaml' : 'json'}"
        resource = "#{safename}/#{res_name}"
        path = "#{project_path}/#{res_name}"
        if File.exists?(path)
          notify(resource, "File already exists - No action", :warning)
        else
          write_result NbmdPs.init(name, options), output_file: path
          notify(resource, "Project metafile created", :success)
        end
        
        # Prepare schemata folder
        res_name = "schemata"
        resource = "#{safename}/#{res_name}"
        path = "#{project_path}/#{res_name}"
        if File.directory?(path)
          notify(resource, "Directory already exists - No action", :warning)
        else
          FileUtils.mkdir_p path
          notify(resource, "Resource definition directory created", :success)
        end
        
        # Prepare schemata/system folder
        res_name = "schemata/system"
        resource = "#{safename}/#{res_name}"
        path = "#{project_path}/#{res_name}"
        if File.directory?(path)
          notify(resource, "Directory already exists - No action", :warning)
        else
          FileUtils.mkdir_p path
          notify(resource, "System schema definition directory created", :success)
          new_project = true
        end
        
        # Create schemata/system/contract.json schema file
        if options[:level] >= 3
          res_name = "schemata/system/contract.#{options[:yaml] ? 'yaml' : 'json'}"
          resource = "#{safename}/#{res_name}"
          path = "#{project_path}/#{res_name}"
          if File.exists?(path)
            notify(resource, "File already exists - No action", :warning)
          else
            write_result NbmdPs.generate('product/contract', options.merge(tpl: 'generate_contract.json.erb')), output_file: path
            notify(resource, "Contract schema created", :success)
          end
        end
        
        # Prepare schemata/products folder
        #res_name = "schemata/products"
        #resource = "#{safename}/#{res_name}"
        #path = "#{project_path}/#{res_name}"
        #if File.directory?(path)
        #  notify(resource, "Directory already exists - No action", :warning)
        #else
        #  FileUtils.mkdir_p path
        #  notify(resource, "Product schema definition directory created", :success)
        #end
        
        # Prepare schemata/accounts folder
        res_name = "schemata/accounts"
        resource = "#{safename}/#{res_name}"
        path = "#{project_path}/#{res_name}"
        if File.directory?(path)
          notify(resource, "Directory already exists - No action", :warning)
        else
          FileUtils.mkdir_p path
          notify(resource, "Accounts schema definition directory created", :success)
        end
        
        if new_project && options[:level] >= 3
          # Create schemata/system/product.json schema file
          res_name = "schemata/accounts/product.#{options[:yaml] ? 'yaml' : 'json'}"
          resource = "#{safename}/#{res_name}"
          path = "#{project_path}/#{res_name}"
          if File.exists?(path)
            notify(resource, "File already exists - No action", :warning)
          else
            write_result NbmdPs.generate('product', options), output_file: path
            notify(resource, "Example account schema created: Product", :success)
          end
          
        end
        
        notify "\n"
      end
    end
  end
end
