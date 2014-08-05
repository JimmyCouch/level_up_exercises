require './split'

describe Split do
	userA = Split.new("A")
	userB = Split.new("B")
	Split.parse(userA,userB)

	context "when a file is parsed" do

		it "the total requests for user A should increment" do
			expect(userA.total).to be > 0
		end
		it "the total requests for user B should increment" do
			expect(userB.total).to be > 0
		end
		it "the converted requests for user A should increment" do
			expect(userA.found).to be > 0
		end
		it "the converted requests for user B should increment" do
			expect(userB.found).to be > 0
		end


	end

	context "when analyzing the data" do
		results = Split.analyze(userA, userB)
		leader = Split.find_leader(userA, userB)
		loser = Split.find_loser(userA, userB)

		it "the conversion rate for user A should be found" do
			expect(userA.conversion_rate).to be > 0
		end

		it "the conversion rate for user B should be found" do
			expect(userB.conversion_rate).to be > 0
		end

		it "the winner should be a user" do
			expect(leader).to be_a User
		end

		it "the loser should be a user" do
			expect(loser).to be_a User
		end

		it "the leader should be confident" do
			expect(leader).to be_confident
		end

		it "The leader should have a standard deviation" do
			expect(leader.find_stdv).not_to be_nil
		end

		it "The leader should have a chi value" do
			expect(leader.find_chi(leader,loser)).to be > 0
		end

		it "the loser should have a standard deviation" do
			expect(loser.find_stdv).not_to be_nil
		end

		it "The result should be a hash" do
			expect(results).to be_a Hash
		end

		it "The result should not be empty" do
			expect(results).not_to be_empty
		end


	end


end