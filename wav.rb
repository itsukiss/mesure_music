require 'wav-file'

BPM = 130.0
sum = 0
cnt = 0
list = Array.new

f = open("jikken.wav")
format = WavFile::readFormat(f)
dataChunk = WavFile::readDataChunk(f)
f.close

puts format

bit = 's*' if format.bitPerSample == 16
bit = 'c*' if format.bitPerSample == 8
wavs = dataChunk.data.unpack(bit)


(0..(wavs.count-1)).each do |x|
	if x%(((44100.0*2)/(BPM/60.0)).round) == 0
		list[cnt] = sum
		sum = 0
		cnt += 1
	end
	sum += wavs[x].abs
end
	# p list
	puts "MAX:#{list.max}"
	puts "MIN:#{list.min}"
	puts "個数:#{list.count}"
	lm = list.max

	list.map! {|item| (item*10.0)/lm}
	list.map! {|item| item.round(1)}
	p list



