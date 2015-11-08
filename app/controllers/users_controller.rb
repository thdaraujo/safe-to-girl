require 'rest_client'

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user?, :except => [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    url = 'https://api.test.sabre.com/v1/lists/utilities/geosearch/locations'
    body = {
       :GeoSearchRQ => {
         :ForPlaces => {
           :OfCategory => [
             {
              "name": "AIR"
             }
           ]
         },
         :Around => {
           :PlaceByLatLong => {
             :latitude => 32.49967,
             :longitude => -97.069927
           },
           :distance => 20
         },
         :ResultSetConfig => {
           :maxResults => 5
         }
       }
     }.to_json
     auth = 'Bearer T1RLAQIiN+IQ0KU23fq/+M0RaSiV7O/VkhCbAaK5n8EjjinIz47bu3DIAACgJ4RQ7NbldJlc8rw0I2WSHTMJ5xI9MF9sTLLLvziRjNwphYHN45OH9igrTtLTcUZaL0pj/dvpUrB269uz6sxydOlpufrMIyryZTenGKfME9ZgdgyJLOAVRIW+kGS7D0s2vndomKFwtqNMGw73+jgLYV1ZLhgm7bcPqcLhEec7oNO32oJOW1MbeuLuAC+/8o03z7g/uOTtMUxkC+EpnR2sAA'

    @info = RestClient.post url, body, :content_type => :json, :accept => :json, :Authorization => auth
  end

end
