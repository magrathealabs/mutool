require 'pathname'

RSpec.describe Mutool do
  let(:tmp) { Pathname.new('.').join('spec', 'tmp') }
  let(:pattern) { 'spec/tmp/convert-test-%d.png' }

  it 'has a version number' do
    expect(Mutool::VERSION).not_to be nil
  end

  it '#convert' do
    expect(tmp.join('convert-test-1.png').exist?).to be_falsey
    Mutool.convert('spec/resources/pdf.pdf', { F: 'png', p: "'; touch abc.png;'", o: pattern })
    expect(tmp.join('convert-test-1.png').exist?).to be_truthy
    expect(File.exist?('abc.png')).to be_falsey
    expect(tmp.join('abc.png').exist?).to be_falsey
  end

  it '#convert with password' do
    expect(tmp.join('convert-test-password-1.png').exist?).to be_falsey
    Mutool.convert('spec/resources/pdf_with_password.pdf', { F: 'png', p: 'abc', o: pattern })
    expect(tmp.join('convert-test-password-1.png').exist?).to be_truthy
  end
end
