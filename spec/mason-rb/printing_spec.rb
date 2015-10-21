RSpec.describe MasonRb::Printing do

  # Make sure that MasonRb::Printing::STATUS_PREFIX exists
  it { is_expected.to have_constant 'STATUS_PREFIX' }

  # Make sure that MasonRb::Printing::DEBUG_PREFIX exists
  it { is_expected.to have_constant 'DEBUG_PREFIX' }

  # Make sure that MasonRb::Printing::ERROR_PREFIX exists
  it { is_expected.to have_constant 'ERROR_PREFIX' }

  # Make sure that MasonRb::Printing::INTAKE_PREFIX exists
  it { is_expected.to have_constant 'INTAKE_PREFIX' }

  # Make sure that MasonRb::Printing::FOOBAR does not exist
  it { is_expected.to_not have_constant 'FOOBAR' }

end