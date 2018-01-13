require 'spec_helper'

describe 'Command Line' do
  let(:bin) { File.expand_path(File.join(__FILE__, '../../../bin/frgom')) }
  describe '#help' do
    it 'displays help' do
      help = `"#{bin}" help`
      expect(help).to include 'frgom - Reticulate splines.'
    end
  end
  describe '#reticulate' do
    it 'reticulates a b-spline' do
      expect(`"#{bin}" --verbose reticulate`).to eq "Reticulating a Frgom::Splines::B ...\n"
    end
  end
end
