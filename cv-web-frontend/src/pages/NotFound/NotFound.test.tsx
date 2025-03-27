import { render, screen } from '@testing-library/react'
import { describe, expect, it } from 'vitest'
import NotFound from './NotFound'
import { MemoryRouter } from 'react-router-dom'

describe('NotFound Page', () => {
  it('renders NotFound page heading', async () => {
    render(
      <MemoryRouter>
        <NotFound />
      </MemoryRouter>,
    )

    const heading = await screen.findByRole('heading', { level: 1 })
    expect(heading).toHaveTextContent('404 Not Found')
  })
})
