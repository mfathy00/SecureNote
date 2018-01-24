require "spec_helper"

RSpec.describe Note do
  describe "Note Test Methods" do
    describe "Secure Note" do
      it "return total" do
        Note.create(title: "Test1", body: "testbody1", password: "Pass1")
        Note.create(title: "Test2", body: "testbody2", password: "Pass2")
        Note.create(title: "Test3", body: "testbody3", password: "Pass3")
        expect(Note.count).to eq(3)
      end
    end
  end
end

RSpec.describe Application do
  describe "POST secure note" do
    it "returns status 201" do
      post "/secure-note", params= {title: "testtitle", body: "testbody", password: "Moha@test"}
      expect(last_response.status).to eq 201
    end
  end
  describe "Delete secure note" do
    it "returns status 204" do
      post "/secure-note", params= {title: "testtitle", body: "testbody", password: "Moha@test"}
      delete "/secure-note/1", params= {password: "Moha@test"}
      expect(last_response.status).to eq 204
    end
    it "returns Wrong password" do
      post "/secure-note", params= {title: "testtitle", body: "testbody", password: "Moha@test"}
      delete "/secure-note/1", params= {password: "Moha"}
      expect(last_response.body).to eq "Wrong password".to_json
    end
  end
  describe "Get secure note" do
    it "returns status 202" do
      post "/secure-note", params= {title: "testtitle", body: "testbody", password: "Moha@test"}
      get "/secure-note/1", params= {password: "Moha@test"}
      expect(last_response.status).to eq 202
    end
    it "returns Wrong password" do
      post "/secure-note", params= {title: "testtitle", body: "testbody", password: "Moha@test"}
      get "/secure-note/1", params= {password: "Moha"}
      expect(last_response.body).to eq "Wrong password".to_json
    end
  end
  describe "Update secure note" do
    it "returns status 200" do
      post "/secure-note", params= {title: "testtitle", body: "testbody", password: "Moha@test"}
      put "/secure-note/1", params= {password: "Moha@test",title: "titleupdate", body: "bodyupdate",}
      expect(last_response.status).to eq 200
    end
    it "returns Wrong password" do
      post "/secure-note", params= {title: "testtitle", body: "testbody", password: "Moha@test"}
      put "/secure-note/1", params= {password: "Moha"}
      expect(last_response.body).to eq "Wrong password".to_json
    end
  end
end
