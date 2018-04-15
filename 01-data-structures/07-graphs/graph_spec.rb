include RSpec

require_relative 'graph'

actors_hash = {
  Kevin_Bacon => Kevin_Bacon,
  Bill_Murray => Bill_Murray,
  Ernie_Hudson => Ernie_Hudson,
  Michael_McKean => Michael_McKean,
  Evan_Rachel_Wood => Evan_Rachel_Wood,
  Paul_Giamatti => Paul_Giamatti,
  Renee_Zellweger => Renee_Zellweger,
  Natalie_Portman => Natalie_Portman,
  Lori_Singer => Lori_Singer,
  John_Lithgow => John_Lithgow,
  Dianne_Wiest => Dianne_Wiest,
  Chris_Penn => Chris_Penn,
  Sarah_Jessica_Parker => Sarah_Jessica_Parker,
  Matt_Dillon => Matt_Dillon,
  Neve_Campbell => Neve_Campbell,
  Theresa_Russell => Theresa_Russell,
  Denise_Richards => Denise_Richards,
  Dan_Aykroyd => Dan_Aykroyd,
  Sigourney_Weaver => Sigourney_Weaver,
  Chevy_Chase => Chevy_Chase,
  Rodney_Dangerfield => Rodney_Dangerfield,
  Ted_Knight => Ted_Knight,
  Brendan_Fraser => Brendan_Fraser,
  Judd_Nelson => Judd_Nelson,
  Larry_David => Larry_David,
  Samantha_Bee => Samantha_Bee,
  Clint_Eastwood => Clint_Eastwood,
  Isaiah_Washington => Isaiah_Washington,
  James_Woods => James_Woods,
  Mickey_Rourke => Mickey_Rourke,
  Marisa_Tomei => Marisa_Tomei,
  Todd_Barry => Todd_Barry,
  Ryan_Gosling => Ryan_Gosling,
  George_Clooney => George_Clooney,
  Russell_Crowe => Russell_Crowe,
  Rosemarie_DeWitt => Rosemarie_DeWitt,
  Tom_Cruise => Tom_Cruise,
  Kelly_Preston => Kelly_Preston,
  Bonnie_Hunt => Bonnie_Hunt,
  Jude_Law => Jude_Law,
  Nicole_Kidman => Nicole_Kidman,
  Julia_Roberts => Julia_Roberts,
  Clive_Owen => Clive_Owen,
  Mila_Kunis => Mila_Kunis,
  Winona_Ryder => Winona_Ryder,
  Barbara_Hershey => Barbara_Hershey,
  Kathy_Bates => Kathy_Bates,
  Anthony_Edwards => Anthony_Edwards,
  Leonardo_DiCaprio => Leonardo_DiCaprio,
  Kate_Winslet => Kate_Winslet,
  Joseph_Gordon_Levitt => Joseph_Gordon_Levitt,
  Ellen_Page => Ellen_Page,
  Tim_Robbins => Tim_Robbins,
  Meg_Ryan => Meg_Ryan,
  Denzel_Washington => Denzel_Washington,
  Stanley_Tucci => Stanley_Tucci,
  Jodie_Foster => Jodie_Foster,
  Willem_Dafoe => Willem_Dafoe,
  Brad_Pitt => Brad_Pitt,
  Michael_Caine => Michael_Caine,
  Woody_Allen => Woody_Allen,
  Steve_Martin => Steve_Martin,
  Glenne_Headley => Glenne_Headley,
  Scarlett_Johansson => Scarlett_Johansson,
  Julianne_Moore => Julianne_Moore,
  Christian_Slater => Christian_Slater,
  Patricia_Arquette => Patricia_Arquette,
  Matthew_McConaughey => Matthew_McConaughey,
  Anne_Hathaway => Anne_Hathaway
}

RSpec.describe Graph, type: Class do
  let (:baconator) { Graph.new(actors_hash) }

  before do
    baconator.actors.each do |key, value|
      value.predecessor = nil
      value.edge_to_source = nil
      value.visited = false
    end
  end

  describe "#find_kevin_bacon" do
    it "returns correct list for Bill Murray" do
      list = baconator.find_kevin_bacon(Bill_Murray)
      expect(list).to eq ["Wild Things"]
    end

    it "returns correct list for Larry David" do
      list = baconator.find_kevin_bacon(Larry_David)
      expect(list).to eq ["Whatever Works", "Airheads", "Ghostbusters", "Wild Things"]
    end

    it "returns correct list for Ellen Page" do
      list = baconator.find_kevin_bacon(Ellen_Page)
      expect(list).to eq ["Inception", "Titanic", "Summer Heat", "Footloose"]
    end

    it "returns correct list for Julia Roberts" do
      list = baconator.find_kevin_bacon(Julia_Roberts)
      expect(list).to eq ["Oceans Eleven", "True Romance", "Footloose"]
    end

    it "returns correct list for Christian Slater" do
      list = baconator.find_kevin_bacon(Christian_Slater)
      expect(list).to eq ["True Romance", "Footloose"]
    end

    it "returns correct list for Natalie Portman" do
      list = baconator.find_kevin_bacon(Natalie_Portman)
      expect(list).to eq ["Black Swan", "Hannah and Her Sisters", "Footloose"]
    end

    it "returns correct list for Tom Cruise" do
      list = baconator.find_kevin_bacon(Tom_Cruise)
      expect(list).to eq ["Top Gun", "Summer Heat", "Footloose"]
    end
  end
end
