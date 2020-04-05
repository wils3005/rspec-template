# rspec-template

## Installation

This project hasn't been submitted to rubygems, so:

```sh
$ git clone https://github.com/wils3005/rspec-template
$ cd rspec-template
$ rake install
```

## Usage
```sh
# use it interactively through irb or pry
# e.g.
$ irb
irb(main):001:0> require 'rspec/template'
=> true
irb(main):002:0> File.write('my_spec.rb', RSpec::Template.new(Object))
=> 128

# a rails generator is also provided
# bundle exec rails generate rspec:template [CLASS_NAME]
# e.g.
$ bundle exec rails generate rspec:template User > user_spec.rb
```

```ruby
# frozen_string_literal: true

RSpec.describe User do
  subject :described_instance do
    described_class.new(attributes, options)
  end

  let :attributes do
    double('attributes')
  end

  let :options do
    double('options')
  end

  describe '.my_class_method' do
    subject :described_method do
      described_class.my_class_method(foo: foo, bar: bar)
    end

    let :foo do
      double('foo')
    end

    let :bar do
      double('bar')
    end

    context 'when called' do
      it 'does not raise an error' do
        expect { described_method }.not_to(raise_error)
      end
    end
  end

  describe '#authenticate' do
    subject :described_method do
      described_instance.authenticate(email, password)
    end

    let :email do
      double('email')
    end

    let :password do
      double('password')
    end

    context 'when called' do
      it 'does not raise an error' do
        expect { described_method }.not_to(raise_error)
      end
    end
  end

  describe '#admin?' do
    subject :described_method do
      described_instance.admin?
    end

    context 'when called' do
      it 'does not raise an error' do
        expect { described_method }.not_to(raise_error)
      end
    end
  end
end
```

## License
Copyright (c) 2020 Jack Wilson. See [LICENSE](LICENSE) for further details.
