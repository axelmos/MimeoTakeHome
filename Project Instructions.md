# Mimeo Take Home Project

## Overview

You will be making a _very_ rudimentary image browser and the start of an editor. This is not expected to be fully polished, much more of a proof of concept. You may apply your own aesthetics to the design but we are more interested in adhering to platform standards than asking for whiz-bang implementation.

This project is a mostly empty skeleton to get you started. The workspace contains both iOS and Mac subprojects and targets: You are expected to choose _either_ platform depending on your preference, _not_ both. This was constructed straight from the templates in Xcode 11.3.1 targeting iOS 13 and macOS 10.15—feel free to edit and rename files as you need.

For simplicity's sake, "tapping" will be used throughout to describe user actions. If you are developing a Mac version, you should of course substitute "click".

An `Images` directory [^1] has been included to use, and is already configured to be copied into your application's bundle. These should not be added to any asset catalog.

*NONE* of this is intended to trip you up. We want you to have some freedom in how you implement this, but if anything feels unclear please ask for clarification.

### Criteria

1. Clean code. Easy to follow, understand, and troubleshoot if necessary.

2. Judicious documentation and code comments.

3. Judicious addition of tests. Code coverage is not enabled, and we don't expect full coverage but if you feel they would be beneficial, add tests. 

4. Git practices. We would like to see the commit history you would normally push up for a pull request, as well as filling out the "Pull Request.md" document as you would the PR for this completed set of changes.

5. Expect to discuss your decisions as part of following interviews.

### Requirements

1. On app launch, present the images on an overview screen using a collection view presenting three equally-sized image cells per row. Each cell should be square, but present the image completely within the cell using aspect fit mode.

2. When the user taps one of the images, present that image in its own fullscreen "Edit" view controller. There should be a way to dismiss this view and return to the overview of images.

3. Add the following buttons to the Edit view controller for the user to "edit" the image:
   - Rotate Counterclockwise (rotate.left SF Symbol or similar). Rotates the image's current orientation 90 degrees counterclockwise.
   - Rotate Clockwise (rotate.right SF Symbol or similar). Rotates the image's current orientation 90 degrees clockwise
   - Original (xmark SF Symbol or similar). Resets _all_ edits (this is not multi-level undo) made in this app, restoring it to the original—but only after confirming with the user.

4. On returning to the overview, the image should reflect the selected rotation in its cell.

5. Returning to the "Edit" view controller for an edited image should present it in the last rotated orientation. Further edits can be made.

6. Images should retain their edited rotation across cold launches of the app.

#### Networking

Add a "Share" button to the editing view controller, whose action is to:

1. Make a GET request to `https://httpbin.org/uuid`, retrieving a random UUID.
2. Insert the retrieved UUID into a POST request to `https://httpbin.org/anything` with a JSON body payload of: 

    ```
    { 
      "uuid": <retrieved_uuid">,
      "filename": <image_filename>,
      "size": { "width": <image_width>, "height": <image_height> },
      "rotation": <image_rotation_in_degrees>
    }
    ```

    [note that rotation of 270 and -90 are equivalent and you are not required to normalize between them]

3. Parse the returned data from the `anything` payload and verify that it returned what you passed it.

Documentation for HTTPBin calls are found at [https://httpbin.org/](https://httpbin.org/), although there aren't direct links:

- `https://httpbin.org/uuid` is found in the "Dynamic Data" section
- `https://httpbin.org/anything` is found in the "Anything" section

## Bonus Ideas

You are not expected to do any of the following items, but you will want to consider how you would go about them for further interview discussion.

- Support both Light and Dark appearance modes.

- Instead of the provided images, use images from the user's photo library. Do not push any edits from this app back to the photo library.

- Add gestures (and any needed interface elements) to allow the user to more directly manipulate the rotation of the image.

--

[^1]: [Photos by Nicole King on Unsplash](https://unsplash.com/@nicolek90)
