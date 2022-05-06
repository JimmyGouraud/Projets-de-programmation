all:
	javac $(shell find . -name \*.java)

run: all
	java pong.Main

clean:
	rm $(shell find . -name \*.class)
	rm -rf Javadoc

doc:
	mkdir -p Javadoc
	javadoc pong/*/*.java pong/*.java -d  Javadoc
