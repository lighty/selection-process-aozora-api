RSpec.describe "Works", type: :request do
  describe "GET /index" do
    before do
      create(:work, name: 'こころ')
      create(:work, name: 'イズムの功過')
    end

    it "returns http success" do
      get "/works"
      expect(response).to have_http_status(:success)
    end

    context '検索文字列を指定した場合' do
      specify '指定した文字列と部分一致する名前を持つレコードで絞り込みされること', :aggrigate_failures do
        get "/works", params: { q: 'こころ' }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq 1
      end
    end
  end
end
