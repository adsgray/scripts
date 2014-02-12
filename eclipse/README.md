# Eclipse IDE

## Hanging on startup (beachball on MacOS)
* Hilariously, this solves it:
  * mv everything out of the workspace (including .metadata directory)
  * restart-then-quit eclipse
  * mv everything back
* Note that the contents of the files has not changed.
