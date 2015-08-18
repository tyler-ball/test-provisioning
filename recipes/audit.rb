control_group "group" do
  control "foo" do
    it "should fail" do
      expect(1).to eq(2)
    end
  end
end
