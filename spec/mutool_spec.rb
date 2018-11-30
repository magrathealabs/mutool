RSpec.describe Mutool do
  it 'has a version number' do
    expect(Mutool::VERSION).not_to be nil
  end

  it '#convert' do
    expect(File.exist?('spec/tmp/convert-test-1.png')).to eq(false)
    Mutool.convert('spec/resources/pdf.pdf', {F: 'png', o: 'spec/tmp/convert-test-%d.png'})
    expect(File.exist?('spec/tmp/convert-test-1.png')).to eq(true)
  end
end
