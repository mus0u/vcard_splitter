defmodule VcardSplitter do

	def parse filename do
		File.open!(filename)
		|> IO.stream(:line)
		|> Enum.reduce(initial_split_state, &split/2)
		|> case(do: ({:scanning, result} -> result))
	end

	defp initial_split_state do
		{:scanning, []}
	end

	# scanning

	defp split "BEGIN:VCARD\n", {:scanning, result} do
		{ :recording, [ "BEGIN:VCARD\n" | result ] }
	end

	defp split _, {:scanning, result} do
		{:scanning, result}
	end

	# recording

	defp split "END:VCARD", {:recording, [current_vcard | rest]} do
		{:scanning, [current_vcard <> "END:VCARD" | rest] }
	end

	defp split "END:VCARD\n", {:recording, [current_vcard | rest]} do
		{:scanning, [current_vcard <> "END:VCARD\n" | rest] }
	end

	defp split line, {:recording, [current_vcard | rest]} do
		{:recording, [current_vcard <> line | rest] }
	end
end
