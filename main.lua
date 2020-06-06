function _init()

  numtable = {
    [8] = {
      { 1, false, false },
      { 1, true, false },
      { 17, false, false },
      { 17, true, false },
      { 17, false, true },
      { 17, true, true },
      { 1, false, true },
      { 1, true, true },
    }
  }

end

function _update()
  year = stat(90)
  month = stat(91)
  day = stat(92)
end

function _draw()
  cls()
  -- print(year.."/"..day.."/"..month)


  -- 8
  for i,v in ipairs(numtable[8]) do
    local idx, fx, fy = v[1], v[2], v[3]
    spr(idx, (i-1)%2*8, (flr((i+1)/2)-1)*8, 1, 1, fx, fy)
  end
end
