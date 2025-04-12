import reactLogo from './../../assets/react.svg'
import viteLogo from '/vite.svg'

import { Link } from 'react-router-dom'

import './Home.css'

function Home() {
  return (
    <>
      <div>
        <a href="https://vite.dev" target="_blank" rel="noreferrer noopener">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank" rel="noreferrer noopener">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + Reactasds</h1>
      <nav>
        <Link to="/jobs">List Jobs</Link> |{' '}
        <Link to="/educations">List Educations</Link>
      </nav>
    </>
  )
}

export default Home
