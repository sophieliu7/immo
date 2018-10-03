class Search < ApplicationRecord

  validates :min_budget, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  validates :max_budget, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  validates :min_living_space, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  validates :max_living_space, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  validates :min_land_area, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  validates :max_land_area, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  # validates :rooms, numericality: { only_integer: true, greater_than: 0 }, :allow_nil => true
  # validates :bedrooms, :allow_nil => true
  # validates :rooms, :allow_nil => true

  def seloger_url

    url_variables = ""

    # url variable generator for string parameters
    string_parameters = [goal, old_new_type, house_type]
    string_reference = {
      "acheter" => "idtt=2",
      "louer" => "idtt=1",
      "maison" =>  "idtypebien=2",
      "appartement" => "idtypebien=1",
      "terrain" => "idtypebien=4",
      "parking box" => "idtypebien=3",
      "loft/atelier" => "idtypebien=9",
    }

    string_parameters.each do |string|
      string_reference.each do |key, value|
        if string == key
          url_variables += value + "&"
          break
        end
      end
    end

    # url variable generator for integer parameters
    url_variables += "pxmin=#{min_budget}&" unless min_budget.nil?
    url_variables += "pxmax=#{max_budget}&" unless max_budget.nil?
    url_variables += "surfacemin=#{min_living_space}&" unless min_living_space.nil?
    url_variables += "surfacemax=#{max_living_space}&" unless max_living_space.nil?

    # url variable generator for Number of rooms
    rooms_reference = {
      "0" => "nb_pieces=1",
      "2" => "nb_pieces=2",
      "3" =>  "nb_pieces=3",
      "4" => "nb_pieces=4",
      "5" => "nb_pieces=%2B4",
    }

    rooms_reference.each do |key, value|
      if rooms.to_s == key
        url_variables += value + "&"
        break
      end
    end

    # url variable generator for number of bedrooms
     bedrooms_reference = {
      "1" => "nb_chambres=1",
      "2" => "nb_chambres=2",
      "3" =>  "nb_chambres=3",
      "4" => "nb_chambres=4",
      "5" => "nb_chambres=%2B4",
    }

    bedrooms_reference.each do |key, value|
      if bedrooms.to_s == key
        url_variables += value + "&"
        break
      end
    end

    url = "https://www.seloger.com/rss,recherche_atom.xml?" + url_variables + "cp=75" + "&tri=d_dt_crea"
    return url
  end


  def seloger_xml_parseur
    require 'rss'
    array = []
    rss = RSS::Parser.parse(seloger_url, false)
    rss.items.each do |item|
      clean_content = item.content.content.gsub(/<img.*/, "")
      image_url = item.content.content.strip.gsub('<img src="', '').split(".jpg").first + ".jpg"
      array << [item.title.content, item.updated.content, clean_content, image_url, item.link.href]
    end
    return array
  end

end
