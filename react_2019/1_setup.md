### Creating your first React app

- react: modern code, sexy code (components etc)

  => problem here

  - browser: does not understand

  => needs to compile the code

  - web pack, babel...

  => solution: `create-react-app`

  - set up react web app by one command
  - `npx create-react-app name_of_app`

- necessities

  - `npm start`
  - `npm build`
  - `npm test`: X
  - `npm eject`: X
  - `yarn.lock`: X

### How does React work?

- directories

  - `node_modules` : no touch
  - `public` 
    - favicon
    - index.html : empty on purpose
    - manifest.json : for PWA (not this course)
  - `src`
    - many js and css

- React creates all the elements by JS and push them into HTML

  - `ReactDOM.render( something to render, where to render)`

  - put HTML without having to putting it at first in the source code

    => fast

    => **Virtual DOM**

    