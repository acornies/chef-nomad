require 'spec_helper'

describe Nomad::Helpers do
  it '#hash_to_args' do
    expect(
      Nomad::Helpers.hash_to_arg_string({
        'config' => '/etc/nomad-conf.d',
        'dev' => nil
      })
    ).to eq '-config=/etc/nomad-conf.d -dev'
  end

  it '#conf_keys_include_opts' do
    validations = Nomad::Helpers.conf_keys_include_opts(%w(foo bar))
    good_conf = {
      'foo' => 'foo',
      :bar => 'bar'
    }

    bad_conf = {
      'baz' => 'baz'
    }

    expect(validations[:kind_of]).to eq(Hash)
    expect(validations[:callbacks].select {|k,v| !v.call(good_conf) }.keys).to be_empty
    expect(validations[:callbacks].select {|k,v| !v.call(bad_conf) }.keys).not_to be_empty
  end
end
