## ABOUT
This is an extractor for Microsoft Excel Chart in unlinked Microsoft Word Document

## HOW TO USE
- Change the extension of Microsoft Word file from `.docx` to `.zip`
- Go to `<file_name>.zip > word > charts` An extract all `chart<number>.xml` file to the `carts` directory
- Run `bundle install`
- Run `ruby main.rb` to start the extraction