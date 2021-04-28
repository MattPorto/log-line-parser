# Log Line Parser
A command line tool that receives a pre-processed log file and tries to get a list of url pages and how many visits each page had based on file infos.

## Installation
Since the application uses only plain Ruby to run, just download the source code. 
You can run `bundle install` to check the test suite and coverage status.

## Dependencies
* Ruby: >= `2.6.6`

## Usage

Just go to root folder and run `ruby run.rb -h` to see available commands:

```
  $ ruby run.rb -h
  Usage: run.rb [options]
    -f, --file_path=FILEPATH         Log file path to be parsed
    -t, --hits                       Show the total of hits on path (include repeated addresses)
    -u, --uniques                    Show only unique hits on path
    -a, --all                        Show unique hits and total hits on path
    -h, --help                       Show commands list
```

ie:
```
ruby run.rb -fspec/fixtures/webserver.log -a                                                                                                                                                          G:main[5Mi] 485978a ⭑ ?
/about/2 90 hit(s), 22 unique(s)
/contact 89 hit(s), 23 unique(s)
/index 82 hit(s), 23 unique(s)
/about 81 hit(s), 21 unique(s)
/help_page/1 80 hit(s), 23 unique(s)
/home 78 hit(s), 23 unique(s)

```

## Tests
To execute the test suite, just run `rspec` (note that you need to run `bundle install` before to download test, coverage and metrics libraries).


## Next Steps
### Potential Improvements
* We could break the architecture to make the code even more readable, separating for example the methods responsibles to handle errors or render results
into modules designed just for it. This could make the `file_handler` class and `data_extractors/line` module tons more readable, and easier to understand and maintain;
* We should improve test coverage, since many of the render methods are not covered;
* We should not read the whole file at once;

