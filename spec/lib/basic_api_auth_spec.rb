RSpec.describe BasicApiAuth, :type => :module do
  let(:app) {
    Rack::Builder.new do
      use BasicApiAuth::Middleware, "snaf-test"
      run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ["Testing Basic APi Auth!"]] }
    end
  }

  describe BasicApiAuth::Middleware do

    it "is successful if passed hashkey is correct" do
      response = Rack::MockRequest.new(app).get('/api/snarf_test?hashkey=350d806c45699b4db9bdf0113505f0bac07526a6&param_a=snarf')
      response.status.should == 200
    end

    it "returns 401 if hashkey authentication fails" do
      response = Rack::MockRequest.new(app).get('/api/test?hashkey=failedkey&param_a=snarf')
      response.status.should == 401
      JSON.parse(response.body).should == { "message" => "Authentication Failed" }
    end

    it "returns 401 - hashkey required, if hashkey is not passed" do
      response = Rack::MockRequest.new(app).get('/api/test?param_a=snarf')
      response.status.should == 401
      JSON.parse(response.body).should == { "message" => "Hashkey is required for authentication" }
    end
  end
end
