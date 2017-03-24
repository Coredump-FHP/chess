class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  #has_many :games
  has_many :pieces

  def games
    Game.where('player_1_id = ? OR player_2_id = ?', id, id)
  end

  def my_games
    if player_signed_in?
      @my_games = Game.where('player_1_id = ? OR player_2_id = ?', current_player.id, current_player.id).order('updated_at').to_a.first(10)
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |player|
      player.email = auth.info.email
      player.password = Devise.friendly_token[0, 20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |player|
      data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']

      if data
        player.email = data['email'] if player.email.blank?
      end
    end
  end
end
