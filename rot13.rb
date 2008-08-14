class String
  def encrypt
     self.tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")
  end
  
  def decrypt
    self.tr("N-Zn-zA-Ma-m","A-Ma-mN-Zn-z")
  end
end
