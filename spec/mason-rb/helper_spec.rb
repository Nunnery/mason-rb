RSpec.describe MasonRb::Helper do

  # Make sure that MasonRb::Helper::FOOBAR does not exist
  it { is_expected.to_not have_constant 'FOOBAR' }

  # Testing MasonRb::Helper.is_ci?
  describe '.is_ci?' do
    # Testing Jenkins support because it's environment variable based
    context 'when running on Jenkins' do
      let(:travis) { ENV['TRAVIS'] }
      let(:jenkins_url) { ENV['JENKINS_URL'] }
      let(:ci) { ENV['CI'] }
      before {
        ENV['TRAVIS'] = nil
        ENV['JENKINS_URL'] = 'http://build.tealcube.com/'
        ENV['CI'] = nil
      }
      after {
        ENV['TRAVIS'] = travis
        ENV['JENKINS_URL'] = jenkins_url
        ENV['CI'] = ci
      }
      let(:on_ci) { MasonRb::Helper.is_ci? }
      it 'returns true' do
        expect(on_ci).to eq true
      end
    end

    # Testing Travis support because it's environment variable based
    context 'when running on Travis' do
      let(:travis) { ENV['TRAVIS'] }
      let(:jenkins_url) { ENV['JENKINS_URL'] }
      let(:ci) { ENV['CI'] }
      before {
        ENV['TRAVIS'] = 'true'
        ENV['JENKINS_URL'] = nil
        ENV['CI'] = 'true'
      }
      after {
        ENV['TRAVIS'] = travis
        ENV['JENKINS_URL'] = jenkins_url
        ENV['CI'] = ci
      }
      let(:on_ci) { MasonRb::Helper.is_ci? }
      it 'returns true' do
        expect(on_ci).to eq true
      end
    end

    # Testing developer workstation because it's environment variable based
    context 'running on developer workstation' do
      let(:travis) { ENV['TRAVIS'] }
      let(:jenkins_url) { ENV['JENKINS_URL'] }
      let(:ci) { ENV['CI'] }
      before {
        ENV['TRAVIS'] = nil
        ENV['JENKINS_URL'] = nil
        ENV['CI'] = nil
      }
      after {
        ENV['TRAVIS'] = travis
        ENV['JENKINS_URL'] = jenkins_url
        ENV['CI'] = ci
      }
      let(:on_ci) { MasonRb::Helper.is_ci? }
      it 'returns false' do
        expect(on_ci).to eq false
      end
    end
  end

  # Testing MasonRb::Helper.is_test?
  # This is kind of hard to test because we're already running in RSpec...
  describe '.is_test?' do
    context 'when using RSpec' do
      let(:on_test) { MasonRb::Helper.is_test? }
      it 'returns true' do
        expect(on_test).to eq true
      end
    end
  end

  describe '::PASTEL' do
    # Make sure that MasonRb::Helper::PASTEL exists
    it { is_expected.to have_constant 'PASTEL' }
    let(:message) { 'Hello, world!' }
    let(:pastel) { Pastel.new }

    it 'colors strings' do
      expect(pastel.green(message)).to eq MasonRb::Helper::PASTEL.green(message)
    end
  end

end