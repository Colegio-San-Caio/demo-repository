import { describe, it, expect } from 'vitest'
import { optimizeEdgeHeaders, shouldBypassCache } from './edge-optimization'

describe('Edge Optimization Prototype', () => {
  it('should add optimization headers', () => {
    const headers = new Headers({ 'content-type': 'application/json' })
    const optimized = optimizeEdgeHeaders(headers)
    expect(optimized.get('x-edge-optimized')).toBe('true')
    expect(optimized.get('cache-control')).toContain('max-age=3600')
  })

  it('should correctly identify paths that bypass cache', () => {
    expect(shouldBypassCache('/api/v1/healthcheck.json')).toBe(true)
    expect(shouldBypassCache('/api/v1/systemcheck.json')).toBe(true)
    expect(shouldBypassCache('/rfc/rfc9000.json')).toBe(false)
  })
})
