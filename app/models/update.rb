class Update < ActiveRecord::Base
  named_scope :not_expired, :conditions => ['expiredate > ?', DateTime.now], :order => "created_at DESC"

  validates_presence_of :name, :anchor, :expiredate
  validates_uniqueness_of :anchor
  # validate expiredate is in the future
  validate :expiredate_in_future
  validate :article_ok

  def expired
    DateTime.now.strftime("%Y-%m-%d %H:%M:%S") > expiredate.strftime("%Y-%m-%d %H:%M:%s")
  end

  def articletext
    RedCloth.new(article).to_html
  end
  
  def postdate
    day = created_at.strftime("%d").to_i
    created_at.strftime("%B #{day}, %Y")
  end

protected
  def article_ok
    errors.add(:article, "contains invalid markup") if article.include?("<") || article.include?(">")
  end
  def expiredate_in_future
    errors.add(:expiredate, "not in the future.") if Time.parse(expiredate.to_s).to_i <= Time.now.utc.to_i
  end
end
