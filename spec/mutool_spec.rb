require 'pathname'

RSpec.describe Mutool do
  let(:tmp) { Pathname.new('.').join('spec', 'tmp') }
  let(:pattern) { 'spec/tmp/convert-test-%d.png' }
  let(:password_pattern) { 'spec/tmp/convert-test-password-%d.png' }

  it 'has a version number' do
    expect(Mutool::VERSION).not_to be nil
  end

  describe('#convert') do
    it '#convert' do
      expect(tmp.join('convert-test-1.png').exist?).to be_falsey
      Mutool.convert('spec/resources/pdf.pdf', { F: 'png', p: "'; touch abc.png;'", o: pattern })
      expect(tmp.join('convert-test-1.png').exist?).to be_truthy
      expect(File.exist?('abc.png')).to be_falsey
      expect(tmp.join('abc.png').exist?).to be_falsey
    end

    it '#convert pdf with password' do
      expect(tmp.join('convert-test-password-1.png').exist?).to be_falsey
      Mutool.convert('spec/resources/pdf_with_password.pdf', { F: 'png', p: 'abc', o: password_pattern })
      expect(tmp.join('convert-test-password-1.png').exist?).to be_truthy
    end
  end

  describe('#clean') do
    it 'pdf with password' do
      output = tmp.join('pdf_without_password.pdf').to_s

      Mutool.clean('spec/resources/pdf_with_password.pdf', output, p: 'abc')

      expect(Mutool.convert(output, { F: 'png', o: pattern }).success?).to be_truthy
    end
  end
end
