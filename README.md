# Nbmd_ps - Nimbus Supplier API v4

JSON Schema tooling for the Nimbus Supplier API version 4. Nbmd_ps allows you to:

1. scaffold an entire JSON schema project, properly structured
2. generate your final json schema in seconds
3. validate your schema, ensure it is nimbus compliant
4. automatically generate the documentation for your API

All in one tool.


## Introduction

Looking at getting started quickly with the Nimbus integration? Read our [GET STARTED](https://bitbucket.org/verecloud/nimbus.supplier.sdk/src/jsonschema/docs-v4/md/GET_STARTED.md) guide.

[JSON Schema](http://json-schema.org/) provides a great way to describe
an API. nbmd_ps provides tools for bootstrapping a description like this,
verifying its completeness, and generating documentation from the
specification.

To learn more about JSON Schema in general, start with
[this excellent guide](http://spacetelescope.github.io/understanding-json-schema/)
and supplement with the [specification](http://json-schema.org/documentation.html).
The JSON Schema usage conventions expected by nbmd_ps specifically are
described in [/docs/schemata.md](/docs/schemata.md).

## Installation

**Note:** nbmd_ps requires you to have ruby and rubygems installed.


Install the command-line tool with:

```bash
# Only available if you have read access to the project
$ cd /tmp
$ git clone git@bitbucket.org:verecloud/nimbus.supplier.sdk.git
$ git co jsonschema
$ gem install tools/nbmd_ps/nbmd_ps-0.7.0.gem
```


**Bundler install** via git **NOT** available for the moment
If you're using nbmd_ps within a Ruby project, you may want to add it
to the application's Gemfile:

```ruby
# Gem install via git
gem 'nbmd_ps', git: 'git@bitbucket.org:verecloud/nimbus.supplier.sdk.git'
```

```bash
$ bundle install
```

## Usage

Nbmd_ps provides 6 main commands:

* `init`: Scaffold a new project
* `generate`: Scaffold resource schemata
* `combine`: Combine schemata and metadata into single schema
* `verify`: Verify a schema
* `doc`: Generate documentation from a schema
* `render`: Render views from schema

Here's an example of going from zero to a full project:

```bash
# Scaffold a new project for a provider level 3 (default)
# This command will create the acme-email folder and bootstrap
# the project with a meta.json file (global definition) plus
# a set of product/system/account resources
$ nbmd_ps init Acme Email

# Or if you prefer the YAML format
$ nbmd_ps init --yaml Acme Email

# Generate your JSON schema from your meta + resource definitions
$ cd acme-email
$ nbmd_ps combine --meta meta.json schemata/ > schema.json

# Check your schema is nimbus-valid
# Note: this may not pass at the moment - hyper-schema is currently work in progress
$ nbmd_ps verify schema.json

# Generate your JSON schema documentation
$ nbmd_ps doc schema.json > schema.md
```

For other supplier levels, you would do the following
```bash
# Scaffold a new project which only contains product provisioning
$ nbmd_ps init --level 2 Acme Email

# Scaffold a new project which only contains product definition
$ nbmd_ps init --level 1 Acme Email

# Different levels can also be generated in YAML format
$ nbmd_ps init --yaml --level 2 Acme Email
```

If you need to create a new resource (product, account or system)
```bash
# Navigate to your project directory
$ cd acme-email

# Generate a new 'Load Balancer' product
$ nbmd_ps generate Load Balancer > schemata/products/load_balancer.json

# If you are working on a project for a level 1 or level 2 supplier, just
# specify the level when creating new resources
# E.g.: level 1 will not generate any link for the product
$ nbmd_ps generate --level 1 Load Balancer > schemata/products/load_balancer.json

# It also works with YAML
$ nbmd_ps generate --yaml --level 1 Load Balancer > schemata/products/load_balancer.yml

# To preview a resource schema without actually generating a file
$ nbmd_ps generate --level 1 Load Balancer
```

`combine` can detect both `*.yml` and `*.json` and use them side by side. For example, if one have a lot of legacy JSON resources and wants to create new resources in YAML format - `combine` will be able to handle it properly.

# Render from schema

```bash
$ nbmd_ps render --template schemata.erb schema.json > schema.md
```

Typically you'll want to prepend header and overview information to
your API documentation. You can do this with the `--prepend` flag:

```bash
$ nbmd_ps doc --prepend overview.md schema.json > schema.md
```

You can also chain commands together as needed, e.g.:

```bash
$ nbmd_ps combine --meta meta.json schemata/ | nbmd_ps verify | nbmd_ps doc --prepend overview.md > schema.md
```

See `nbmd_ps <command> --help` for additional usage details.

## Documentation rendering settings

Out of the box you can supply a settings file (in either `JSON` or `YAML`) that will tweak the layout of your documentation.

```bash
$ nbmd_ps doc --settings config.json schema.json > schema.md
```

Available options (and their defaults)
```json
{
  "doc": {
    "url_style": "default", // can also be "json"
    "disable_title_and_description": false // remove the title and the description, useful when using your own custom header
  }
}
```

## Use as rake task

In addition, nbmd_ps can be used via rake tasks

```ruby
# Rakefile
require 'nbmd_ps/rake_tasks/combine'
require 'nbmd_ps/rake_tasks/verify'
require 'nbmd_ps/rake_tasks/doc'

namespace :schema do
  Nbmd_ps::RakeTasks::Combine.new do |t|
    t.options[:meta] = 'schema/meta.json'    # use meta.yml if you prefer YAML format
    t.paths << 'schema/schemata/api'
    t.output_file = 'schema/api.json'
  end

  Nbmd_ps::RakeTasks::Verify.new do |t|
    t.files << 'schema/api.json'
  end

  Nbmd_ps::RakeTasks::Doc.new do |t|
    t.files = { 'schema/api.json' => 'schema/api.md' }
  end
end

task default: ['schema:combine', 'schema:verify', 'schema:doc']
```

## File Layout

We suggest the following file layout for JSON schema related files:

```
/docs (top-level directory for project documentation)
  /schema (API schema documentation)
    /schemata
      /account
        /{organization.[json,yml]} (individual account schema - level 3 only)
      /products
        /{virtual_machine.[json,yml]} (individual product schema - all levels)
      /system
        /{event.[json,yml]} (system usage/event/statistic resources - level 3 only)
    /meta.[json,yml] (overall API metadata)
    /overview.md (preamble for generated API docs)
    /schema.json (complete generated JSON schema file)
    /schema.md (complete generated API documentation file)
```

where `[json,yml]` means that it could be either `json` or `yml`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
