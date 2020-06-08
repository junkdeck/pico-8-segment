function stringdigit(n, x, y, pad)
  pad = pad or " "
  x = x or 0
  y = y or 0
  ns=tostr(n)
  if(#ns==1 and ns != "c") then ns=pad..ns end
  for i=1,#ns do
    c=sub(ns,i,i)
    if(c != "c") then 
      c = tonum(c) 
    end
    t=nums[c]

    drawdigit(t, x+(18*(i-1)), y)
  end
end

function drawdigit(t, x, y)
  -- draws a digit from supplied table
  x = x or 0
  y = y or 0
  for i,v in ipairs(t) do
    -- 1: index, 2: fx, 3: fy
    fx=false
    fy=false
    if(sub(v,2,2) == "1") then fx=true end
    if(sub(v,3,3) == "1") then fy=true end

    spr(sub(v,1,1), x+(i-1)%2*8, y+(flr((i+1)/2)-1)*8, 1, 1, fx, fy)
  end
end

function _init()
  nums = {
    [0] = { '100', '110', '600', '610', '601', '611', '101', '111', },
    [1] = { '000', '310', '000', '610', '000', '611', '000', '311', },
    [2] = { '210', '110', '510', '410', '401', '501', '101', '201', },
    [3] = { '210', '110', '510', '410', '511', '411', '211', '111', },
    [4] = { '300', '310', '400', '410', '511', '411', '001', '311', },
    [5] = { '100', '200', '400', '500', '511', '411', '211', '111', },
    [6] = { '100', '200', '400', '500', '401', '411', '101', '111', },
    [7] = { '210', '110', '000', '610', '000', '611', '000', '311', },
    [8] = { '100', '110', '400', '410', '401', '411', '101', '111', },
    [9] = { '100', '110', '400', '410', '511', '411', '211', '111', },
    c = { '000', '300', '000', '301', '000', '300', '000', '301', },
  }

end

function _update()
  year = stat(90)
  month = stat(91)
  day = stat(92)
  h = stat(93)
  m = stat(94)
  s = stat(95)
end

function _draw()
  cls()
  -- print(year.."/"..day.."/"..month)

  drawdigit(nums[8])
end
