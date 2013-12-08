compile:
	ghc --make -threaded compile.hs

build:
	./compile build

rebuild:
	./compile rebuild

watch: 
	./compile watch &

server:
	./compile server

deploy:
	./compile deploy

clean:
	rm compile.hi compile.o

cleancache:
	./compile clean