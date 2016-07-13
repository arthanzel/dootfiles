var fs      = require("fs");
var os      = require("os");
var path    = require("path");

// Make sure we're in the dootfiles dir so relative paths will work.
process.chdir(__dirname);

// Install task
if (process.argv.length <= 2 || process.argv[2] == "install") {
    var linkables = findLinkables();

    for (linkable of linkables) {
        // Remove the .link suffix and fully qualify.
        var sourceFile = path.resolve(linkable);
        var targetFile = path.resolve(os.homedir(), "." + path.parse(linkable.replace(/\.link$/, "")).name);

        if (fs.existsSync(targetFile)) {
            var targetPath = path.parse(targetFile);
            console.log("File already exists: " + targetPath.name);
            console.log("  [s]kip, [o]verwrite, [b]ackup" );
        }
    }
}

// Find linkables.
function findLinkables(dir) {
    if (!dir) dir = ".";

    var linkables = [];

    var files = fs.readdirSync(dir);
    for (file of files) {
        file = path.join(dir, file);
        var stat = fs.statSync(file);
        if (stat.isDirectory() && file.charAt(0) != ".") {
            var subfiles = findLinkables(file);
            linkables = linkables.concat(subfiles);
        }
        else if (stat.isFile() && file.charAt(0) != ".") {
            if (file.substr(-5) == ".link") {
                linkables.push(file);
            }
        }
    }

    return linkables;
};

function backupFile(file, timestamp) {
    if (!fs.existsSync("./_backup")) {
        fs.mkdirSync("_backup");
        console.log("Created backup at " + path.join(process.cwd(), "_backup"));
    }

    
}
