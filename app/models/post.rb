class Post < ActiveRecord::Base
  resourcify
  include Authority::Abilities

  # 제목과 내용을 작성하지 않을때 예외처리 문
  validates :title, presence: { message: "제목을 입력하지 않았습니다." }
  validates :content, presence: { message: "내용을 입력하지 않았습니다." }

  belongs_to :user
end
