function dayofweek()

end

function anchor(year)
  return 5*((year\100)%4)+2
end

function doomsday(year)
  x = anchor(year)
  y = year%100 -- last two digits

  a=y\12
  b=y%12
  c=b\4
  d=(a+b+c)%7

  return (x+d)%7 -- doomsday
end

function weekday(year, month, day)
  x = doomsday(year)
  y = ((day)+x)\7
  return days[(y+1)%#days]
end

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
  x_timer = 1


  ct = 1
  ctypes={12, 24}
  ctype = ctypes[ct+1]

  zone=0
  alarmset=false

end

function _update()
  year = stat(90)
  month = stat(91)
  day = stat(92)
  h = stat(93)
  m = stat(94)
  s = stat(95)

  -- left offset
  loff = 12
  -- top offset
  toff = 12

  fh=h%ctype --formatted hour
  if(ctype!=24 and fh==0)then fh=12 end

  -- toggle alarm
  if(btnp(4)) then
    alarmset = not alarmset 
  end
  -- toggle clock hour mode
  if(btn(5)) then
    x_timer += 1
  elseif(x_timer > 0) then
    if(x_timer < CHR_TIMER_THRESH) then
      ct = ct ^^ 1
      ctype=ctypes[ct+1]
    end
    x_timer = 0
  end

  datestr = weekday(year, month, day)..", "..months[month].." ".."9".." "..year
end

function _draw()
  cls()

  -- swap dark purple with alternative palette 
  pal(2,129,1)
  pal(8,2)
  -- draw inactive LCD segments
  drawdigit(nums[8],loff, 64-toff)
  drawdigit(nums[8],loff+18, 64-toff)
  drawdigit(nums.c,loff+36, 64-toff)
  drawdigit(nums[8],loff+56, 64-toff)
  drawdigit(nums[8],loff+74, 64-toff)
  spr(8, 104, 48)
  spr(7, 108, 58)
  spr(10, 110, 48)
  pal(8,8)

  color(8)
  if(ctype!=24) then
    if(h < 12) then zone=8 else zone=9 end
    spr(zone, 104, 48)
    spr(10, 110, 48)
  end

  if(alarmset) then spr(7, 108, 58) end

  stringdigit(fh,loff,64-toff)
  if(s % 2 == 0) then
    stringdigit("c",loff+36,64-toff)
  end
  stringdigit(m,loff+56,64-toff, 0 )

  color(8)
  print(datestr, 65-((#datestr/2)*5), 92)

end
