require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReviewsHelper. For example:
#
# describe ReviewsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ReviewsHelper, type: :helper do
  context 'star_rating' do
    it 'does nothing for not a number' do
      expect(helper.star_rating('N/A')).to eq('N/A')
    end

    it 'returns five black stars for five' do
      expect(helper.star_rating(5)).to eq '★★★★★'
    end

    it 'returns three black stars and two white stars for three' do
      expect(helper.star_rating(3)).to eq '★★★☆☆'
    end

    it 'returns four black stars and one white star for 3.5' do
      expect(helper.star_rating(3.5)).to eq '★★★★☆'
    end
  end

  context 'created_since' do
    it 'returns 0 for recently created reviews' do
      expect(helper.created_since(Time.now)).to eq('0 hours')
    end

    it 'returns 1 for recently created reviews' do
      expect(helper.created_since(Time.now - 3600)).to eq('1 hour')
    end

    it 'returns 1 for recently created reviews' do
      expect(helper.created_since(Time.now - 7500)).to eq('2 hours')
    end
  end
end
