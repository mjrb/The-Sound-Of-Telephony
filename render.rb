#people on the internet said is shouldn't do this but i did it anyway
require "erb"

#stuff to convert pitch names to musescore pitch and tpc
$pitches=Hash.new
$pitches["F"]=[65,13]
$pitches["G"]=[67,15]
$pitches["Ab"]=[68,10]
$pitches["Bb"]=[70,12]
$pitches["D"]=[74,16]
$pitches["E"]=[76,18]
$pitches["F#"]=[78,20]

def get_pitch name
  $pitches[name][0]
end

def get_tpc name
  $pitches[name][1]
end

#generates xml for accidentals
def gen_accidental type
  if type=="b"
    return "<Accidental><subtype>flat</subtype></Accidental>"
  elsif type=="#"
    return "<Accidental><subtype>sharp</subtype></Accidental>"
  elsif type=="n"
    return "<Accidental><subtype>natural</subtype></Accidental>"
  end
  ""
end


#encapsulates note values
class Note
  def initialize name
    if name.length>2||name.length==0
      raise "illegal note name"
    end
    if name.length==2
      @accidental=gen_accidental name[1]
    else
      @accidental=""
    end
    @pitch=get_pitch name
    @tpc=get_tpc name
  end
  attr_accessor :pitch, :tpc, :accidental
end

#enapsulates chord values
class Chord
  def initialize pitch1, pitch2, duration
    @notes=[]
    @notes.push Note.new(pitch1)
    @notes.push Note.new(pitch2)
    @duration=duration
  end
  def pitches value
    @notes[value].pitch
  end
  def accidentals value
    @notes[value].accidental
  end
  def tpc value
    @notes[value].tpc
  end
  attr_accessor :duration
end

#build an array of chords and have erb deal with it
$chords=[]
def chord pitch1, pitch2, duration
  $chords.push Chord.new(pitch1, pitch2, duration)
end
chords=$chords

#every phone number has 10 digits
#having notes with these lengths makes it into 3 measures
$durations=["quarter", "quarter", "half", "quarter", "quarter", "half", "quarter", "quarter", "quarter", "quarter"]

#decode table to row and coll numbers where 0 is at 1, 2
$melody=["D", "E", "F#"]
$bass=["F", "G", "Ab", "Bb"]

def number num, duration
  col=num%3-1
  row=num/3
  if num%3==0
    col=2
    row-=1
  end
  if num==0
    col=1
    row=3
  end
  melodyName=$melody[col]
  bassName=$bass[row]
  chord bassName, melodyName, duration
end

#begin to process input
$digits=ARGV[0]
#make sure its the correct length
if $digits.length!=10
  raise "only us phone numbers :C"
end
#make sure its a number
begin
  Integer($digits)
rescue
  raise "input must be a number"
end

#punch your digits into my xml file
for i in 0..9
  number $digits[i].to_i, $durations[i]
end
digits=$digits

puts ERB.new(File.read("template.erb")).result(binding)
