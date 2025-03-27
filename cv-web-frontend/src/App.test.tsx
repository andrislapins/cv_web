import { screen } from '@testing-library/react'
import { describe, it, expect } from 'vitest'

import App from './App'
import { renderWithProviders } from './test-utils/renderWithProviders'

describe('App Routing', () => {
  it('renders Home page at "/"', async () => {
    renderWithProviders(<App />, { route: '/' })
    expect(await screen.findByRole('heading', { level: 1 })).toHaveTextContent(
      'Vite + React',
    )
  })

  it('renders Jobs page at "/jobs"', async () => {
    renderWithProviders(<App />, { route: '/jobs' })
    expect(await screen.findByText('Jobs from backend:')).toBeInTheDocument()
  })

  it('renders Educations page at "/educations"', async () => {
    renderWithProviders(<App />, { route: '/educations' })
    expect(
      await screen.findByText('Educations from backend:'),
    ).toBeInTheDocument()
  })
})
