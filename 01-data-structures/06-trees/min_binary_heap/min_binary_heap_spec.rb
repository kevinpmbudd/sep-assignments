include RSpec

require_relative 'min_binary_heap'

RSpec.describe MinBinaryHeap, type: Class do

  let (:heap) { MinBinaryHeap.new }
  let (:matrix) { Node.new("The Matrix", 87) }
  let (:pacific_rim) { Node.new("Pacific Rim", 72) }
  let (:braveheart) { Node.new("Braveheart", 78) }
  let (:jedi) { Node.new("Star Wars: Return of the Jedi", 80) }
  let (:donnie) { Node.new("Donnie Darko", 85) }
  let (:inception) { Node.new("Inception", 86) }
  let (:district) { Node.new("District 9", 90) }
  let (:shawshank) { Node.new("The Shawshank Redemption", 91) }
  let (:martian) { Node.new("The Martian", 92) }
  let (:hope) { Node.new("Star Wars: A New Hope", 93) }
  let (:empire) { Node.new("Star Wars: The Empire Strikes Back", 94) }
  let (:mad_max_2) { Node.new("Mad Max 2: The Road Warrior", 98) }

  describe "#insert(data)" do
    it "properly inserts the first node as root" do
      heap.insert(matrix)
      expect(heap.root.title).to eq "The Matrix"
    end

    it "properly inserts a left child" do
      heap.insert(matrix)
      heap.insert(pacific_rim)
      expect(heap.left_child(pacific_rim).title).to eq "The Matrix"
    end

    it "properly inserts a right child" do
      heap.insert(pacific_rim)
      heap.insert(matrix)
      heap.insert(shawshank)
      expect(heap.right_child(pacific_rim).title).to eq "The Shawshank Redemption"
    end

    it "properly inserts a left-left child" do
      heap.insert(pacific_rim)
      heap.insert(matrix)
      heap.insert(shawshank)
      heap.insert(martian)
      expect(heap.left_child(heap.left_child(pacific_rim)).title).to eq "The Martian"
    end

    it "properly inserts a left-right child" do
      heap.insert(pacific_rim)
      heap.insert(matrix)
      heap.insert(shawshank)
      heap.insert(martian)
      heap.insert(hope)
      expect(heap.right_child(heap.left_child(pacific_rim)).title).to eq "Star Wars: A New Hope"
    end

    it "properly inserts a right-left child" do
      heap.insert(pacific_rim)
      heap.insert(matrix)
      heap.insert(shawshank)
      heap.insert(martian)
      heap.insert(hope)
      heap.insert(empire)
      expect(heap.left_child(heap.right_child(pacific_rim)).title).to eq "Star Wars: The Empire Strikes Back"
    end

    it "properly inserts a right-right child" do
      heap.insert(pacific_rim)
      heap.insert(matrix)
      heap.insert(shawshank)
      heap.insert(martian)
      heap.insert(hope)
      heap.insert(empire)
      heap.insert(mad_max_2)
      expect(heap.right_child(heap.right_child(pacific_rim)).title).to eq "Mad Max 2: The Road Warrior"
    end

    it "properly inserts a node at root if it is lowest value in heap" do
      heap.insert(martian)
      heap.insert(braveheart)
      heap.insert(donnie)
      heap.insert(matrix)
      heap.insert(hope)
      heap.insert(pacific_rim)
      expect(heap.root.title).to eq "Pacific Rim"
    end
  end

  describe "#find(data)" do
    it "handles nil gracefully" do
      heap.insert(empire)
      heap.insert(mad_max_2)
      expect(heap.find(nil)).to eq nil
    end

    it "returns the proper node" do
      heap.insert(donnie)
      expect(heap.find(donnie.title).title).to eq "Donnie Darko"
    end

    it "returns the proper node" do
      heap.insert(martian)
      heap.insert(braveheart)
      heap.insert(pacific_rim)
      expect(heap.find(pacific_rim.title).title).to eq "Pacific Rim"
    end

    it "returns the proper node" do
      heap.insert(martian)
      heap.insert(braveheart)
      heap.insert(donnie)
      heap.insert(matrix)
      heap.insert(hope)
      expect(heap.find(matrix.title).title).to eq "The Matrix"
    end
  end

  describe "#find_index(node)" do
    it "handles nil gracefully" do
      heap.insert(empire)
      heap.insert(mad_max_2)
      expect(heap.find_index(nil)).to eq nil
    end

    it "properly finds index of a left node" do
      heap.insert(pacific_rim)
      heap.insert(hope)
      index = heap.find_index(hope)
      expect(index).to eq 1
    end

    it "properly finds index of a left node" do
      heap.insert(pacific_rim)
      heap.insert(hope)
      heap.insert(empire)
      index = heap.find_index(empire)
      expect(index).to eq 2
    end

    # it "properly find_indexs a left-left node" do
    #   heap.insert(heap, braveheart)
    #   heap.insert(heap, pacific_rim)
    #   expect(heap.find_index(heap, pacific_rim.title).title).to eq "Pacific Rim"
    # end
    #
    # it "properly find_indexs a left-right node" do
    #   heap.insert(heap, donnie)
    #   heap.insert(heap, inception)
    #   expect(heap.find_index(heap, inception.title).title).to eq "Inception"
    # end
    #
    # it "properly find_indexs a right node" do
    #   heap.insert(heap, district)
    #   expect(heap.find_index(heap, district.title).title).to eq "District 9"
    # end
    #
    # it "properly find_indexs a right-left node" do
    #   heap.insert(heap, hope)
    #   heap.insert(heap, martian)
    #   expect(heap.find_index(heap, martian.title).title).to eq "The Martian"
    # end
    #
    # it "properly find_indexs a right-right node" do
    #   heap.insert(heap, empire)
    #   heap.insert(heap, mad_max_2)
    #   expect(heap.find_index(heap, mad_max_2.title).title).to eq "Mad Max 2: The Road Warrior"
    # end
  end

  describe "#delete(data)" do
    it "handles nil gracefully" do
      expect(heap.delete(nil)).to eq nil
    end

    it "properly deletes a left node" do
      heap.insert(pacific_rim)
      heap.insert(hope)
      heap.delete(hope.title)
      expect(heap.find_index(hope)).to be_nil
    end

    it "properly deletes a left-left node" do
      heap.insert(pacific_rim)
      heap.insert(matrix)
      heap.insert(shawshank)
      heap.insert(martian)
      heap.delete(martian.title)
      expect(heap.find_index(martian)).to be_nil
    end

    it "properly deletes a root node" do
      heap.insert(pacific_rim)
      heap.insert(matrix)
      heap.insert(shawshank)
      heap.insert(martian)
      heap.delete(pacific_rim.title)
      expect(heap.find_index(pacific_rim)).to be_nil
    end

    it "properly deletes a middle node" do
      heap.insert(matrix)
      heap.insert(hope)
      heap.insert(empire)
      heap.insert(jedi)
      heap.insert(martian)
      heap.insert(pacific_rim)
      heap.insert(inception)
      heap.insert(braveheart)
      heap.insert(shawshank)
      heap.insert(district)
      heap.insert(donnie)
      heap.insert(mad_max_2)
      heap.delete(martian.title)
      expect(heap.find_index(martian)).to be_nil
    end

    it "properly deletes a node with two children" do
      heap.insert(matrix)
      heap.insert(hope)
      heap.insert(empire)
      heap.insert(jedi)
      heap.insert(martian)
      heap.insert(pacific_rim)
      heap.insert(inception)
      heap.insert(braveheart)
      heap.insert(shawshank)
      heap.insert(district)
      heap.insert(donnie)
      heap.insert(mad_max_2)
      heap.delete(braveheart.title)
      expect(heap.find_index(braveheart)).to be_nil
    end
  end

  describe "#printf" do
     specify {
       expected_output = "Pacific Rim: 72\nBraveheart: 78\nThe Matrix: 87\nStar Wars: Return of the Jedi: 80\nDistrict 9: 90\nThe Martian: 92\nStar Wars: A New Hope: 93\nInception: 86\nStar Wars: The Empire Strikes Back: 94\nThe Shawshank Redemption: 91\nMad Max 2: The Road Warrior: 98\n"
       heap.insert(matrix)
       heap.insert(hope)
       heap.insert(empire)
       heap.insert(jedi)
       heap.insert(martian)
       heap.insert(pacific_rim)
       heap.insert(inception)
       heap.insert(braveheart)
       heap.insert(shawshank)
       heap.insert(district)
       heap.insert(mad_max_2)
       expect { heap.printf }.to output(expected_output).to_stdout
     }

     specify {
       expected_output = "Pacific Rim: 72\nBraveheart: 78\nStar Wars: Return of the Jedi: 80\nDonnie Darko: 85\nInception: 86\nDistrict 9: 90\nThe Shawshank Redemption: 91\nThe Martian: 92\nMad Max 2: The Road Warrior: 98\nStar Wars: The Empire Strikes Back: 94\nStar Wars: A New Hope: 93\n"
       heap.insert(donnie)
       heap.insert(mad_max_2)
       heap.insert(district)
       heap.insert(shawshank)
       heap.insert(braveheart)
       heap.insert(inception)
       heap.insert(pacific_rim)
       heap.insert(martian)
       heap.insert(jedi)
       heap.insert(empire)
       heap.insert(hope)
       expect { heap.printf }.to output(expected_output).to_stdout
     }
  end

end
