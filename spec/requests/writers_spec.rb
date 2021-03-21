RSpec.describe "Writers", type: :request do
  describe "GET /index" do
    before do
      create(:writer, :with_work, name: '芥川 竜之介')
      create(:writer, :with_work, name: '夏目 漱石')
    end

    it "returns http success" do
      get "/writers"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq 2
    end

    context '検索文字列を指定した場合' do
      specify '指定した文字列と部分一致する名前を持つレコードで絞り込みされること' do
        get "/writers", params: { q: '夏目' }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq 1
      end
    end
  end
end
