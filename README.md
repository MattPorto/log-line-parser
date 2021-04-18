# Log Line Parser
SP Ruby Technical Assessment

## Funcionality
This is a command line tool that receives a pre-processed logfile and try to get a list of url pages and how many visits each page had based on file infos.

```
ruby run.rb -fspec/fixtures/webserver.log -a                                                                                                                                                          G:main[5Mi] 485978a ⭑ ?
/about/2 90 hit(s), 22 unique(s)
/contact 89 hit(s), 23 unique(s)
/index 82 hit(s), 23 unique(s)
/about 81 hit(s), 21 unique(s)
/help_page/1 80 hit(s), 23 unique(s)
/home 78 hit(s), 23 unique(s)

```

## Instalation
Since the aplication uses only plain Ruby to run, just download the source code. You can run `bundle install` to check the test suite and coverage status.

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

## Tests
The application is `96.61%` covered with tests (it reached 97%, 
but due to lack of time for maintenance and test coverage improvements, some refactors was needed and
it was not reflected on test suite).

To execute the tests, just run `rspec` (note that you need to run `bundle install` before to download test, coverage and metrics libraries).

## Architecture
This project is running in Ruby `2.6.6` the latest before Ruby `2.7` (pre Ruby 3).

The application presents basic concepts of project architecture and software development best practices, it was built mostly based on DRY and SOLID subjects.

Basically, we have an entry point called `run.rb`, which is responsible to handle the CLI commands mapping, and accept a "file IO" 
stream (i.e. the log file to analyse) as parameter. Once the entry point mapped those parameters, it pass they to the next layer, 
responsible to make the initial validations.

Once that all is valid until here, the file is passed forward in the flow, where each line is extracted one by one and processed by some helper modules.
If any problem is faced during this process, all the flow is aborted and the error is returned as the result of file analysis.

About the separation of responsibilities, the whole architecture was built thinking about that. In the main points of the flow explained above, we have:

* `run.rb`- The entry point of application, responsible to handle command line interactions and pass arguments to file handler class. 
* `lib/file_handler.rb` - This class handles the whole flow of extract data of the file and render the results (or error, based on file processment). This basically
act as a manager of data process, since it calls other modules and methods according with they responsibillity in the process flow.
* `lib/data_extractors` - Folder containing two modules responsibles for handle data extractors and error rescues.
* `lib/data_extractors/base.rb` - This module looks for the file by it's file path and do some error rescues related to file assessment 
(ie: no file or empty file supplied). Also, it passes each line of the file for the next module, and then pass the processed data back again to `file_handler.rb`
* `lib/data_extractors/line.rb` - Responsible for the remaining part of the process, which is receive a given line, and if it matches the validations extract data
from it, reorganizes it's data and then send it back to be rendered by `file_handler.rb`

## Performance
Performance was not the intention of the test, but the whole flow works in a pretty nice time since it runs only ruby to do the processment. But our biggest file 
to test it's performance have only 500 lines, so the performance could not be tracked with precision. Anyway, the code can easily be improved to be able to process
more robust files, making use of Sidekiq to queue line processments and make it asynchronous, for example.

## Next Steps
### Potential Improvements
* We could break the architecture to make the code even more readable, separating for example the methods responsibles to handle errors or render results
into modules designed just for it. This could make `file_handler` class and `data_extractors/line` module tons more readable, and easier to understand and maintain.
* We should improve test coverage, since many of render methods are not covered.


