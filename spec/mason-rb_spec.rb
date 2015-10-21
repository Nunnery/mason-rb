RSpec.describe MasonRb do
  # Make sure that MasonRb::VERSION exists
  it { is_expected.to have_constant 'VERSION' }

  # Make sure that MasonRb::ROOT exists
  it { is_expected.to have_constant 'ROOT' }

  # Make sure that MasonRb::FOOBAR does not exist
  it { is_expected.to_not have_constant 'FOOBAR' }
end