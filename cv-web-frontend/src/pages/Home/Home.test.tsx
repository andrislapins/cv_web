import { render, screen } from '@testing-library/react'
import { describe, expect, it } from 'vitest'
import { MemoryRouter } from 'react-router-dom'

import Home from './Home'

describe('Home Page', () => {
  it('renders Home page heading', async () => {
    render(
      <MemoryRouter>
        <Home />
      </MemoryRouter>,
    )

    const heading = await screen.findByRole('heading', { level: 1 })
    expect(heading).toHaveTextContent('Vite + React')
  })
})
