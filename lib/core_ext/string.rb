class String
  def to_hours
    s = self.dup
    s.strip!
    if s =~ %r{^(\d+([.,]\d+)?)h?$}
      s = $1
    else
      # 2:30 => 2.5
      s.gsub!(%r{^(\d+):(\d+)$}) { $1.to_i + $2.to_i / 60.0 }
      # 2h30, 2h, 30m => 2.5, 2, 0.5
      s.gsub!(%r{^((\d+)\s*(h|hours?))?\s*((\d+)\s*(m|min)?)?$}) { |m| ($1 || $4) ? ($2.to_i + $5.to_i / 60.0) : m[0] }
    end
    # 2,5 => 2.5
    s.gsub!(',', '.')
    begin; Kernel.Float(s); rescue; nil; end
  end
end
