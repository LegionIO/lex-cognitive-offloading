# lex-cognitive-offloading

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`

## Purpose

Extended cognition / cognitive offloading model. Items are delegated to external stores to free internal cognitive capacity. External stores (database, file, agent, tool, memory_aid, external_service, notes) have trust scores that decay on retrieval failure and boost on success. Models the real cognitive strategy of outsourcing memory and computation to reliable external systems, with reliability tracking to reflect varying store trustworthiness.

## Gem Info

- **Gem name**: `lex-cognitive-offloading`
- **Module**: `Legion::Extensions::CognitiveOffloading`
- **Version**: `0.1.0`
- **Ruby**: `>= 3.4`
- **License**: MIT

## File Structure

```
lib/legion/extensions/cognitive_offloading/
  version.rb
  client.rb
  helpers/
    constants.rb
    offloaded_item.rb
    offloading_engine.rb
  runners/
    cognitive_offloading.rb
```

## Key Constants

| Constant | Value | Purpose |
|---|---|---|
| `MAX_ITEMS` | `500` | Per-engine item capacity |
| `MAX_STORES` | `50` | Per-engine store capacity |
| `DEFAULT_STORE_TRUST` | `0.7` | Starting trust for new stores |
| `TRUST_DECAY` | `0.02` | Trust reduction per retrieval failure |
| `TRUST_BOOST` | `0.05` | Trust increase per successful retrieval |
| `RETRIEVAL_SUCCESS_THRESHOLD` | `0.7` | Minimum trust level for a store to be considered reliable |
| `ITEM_TYPES` | symbol array | Valid item type categories |
| `STORE_TYPES` | `%i[database file agent tool memory_aid external_service notes]` | Valid store types |
| `TRUST_LABELS` | range hash | From `:unreliable` to `:highly_trusted` |
| `IMPORTANCE_LABELS` | range hash | Item importance labels |
| `OFFLOAD_LABELS` | range hash | Offloading ratio labels |

## Helpers

### `Helpers::OffloadedItem`
Single offloaded item. Has `id`, `content`, `item_type`, `store_id`, `importance`, `offloaded_at`, and `retrieved_at`.

- `retrieve!` — sets `retrieved_at` to current time
- `stale?` — offloaded more than a threshold time ago without retrieval
- `importance_label`

### `Helpers::OffloadingEngine`
Multi-store offloading manager. Enforces `MAX_ITEMS` and `MAX_STORES`.

- `register_store(name:, store_type:, trust:)` → store record
- `offload(content:, item_type:, store_id:, importance:)` → offloaded item
- `retrieve(item_id:)` → item + records success on the store (boosts trust by `TRUST_BOOST`)
- `retrieve_failed(item_id:)` → records failure on the store (decays trust by `TRUST_DECAY`)
- `items_in_store(store_id:)` → items belonging to a store
- `items_by_type(item_type:)` → filtered items
- `most_important_offloaded(limit:)` → top N by importance
- `offloading_ratio` → ratio of offloaded items to total capacity
- `overall_store_trust` → mean trust across all stores
- `offloading_report` → aggregate stats including unreliable store list

## Runners

Module: `Runners::CognitiveOffloading`

| Runner Method | Description |
|---|---|
| `register_store(name:, store_type:, trust:)` | Register an external store |
| `offload_item(content:, item_type:, store_id:, importance:)` | Offload an item to a store |
| `retrieve_item(item_id:)` | Retrieve and record success |
| `report_retrieval_failure(item_id:)` | Record failure and decay store trust |
| `items_in_store(store_id:)` | Items in a specific store |
| `items_by_type(item_type:)` | Items of a specific type |
| `most_important_offloaded(limit:)` | Top N by importance |
| `offloading_status` | Full offloading report |

All runners return `{success: true/false, ...}` hashes.

## Integration Points

- `lex-memory`: offloading is the agent-to-external complement to in-memory trace storage
- `lex-mesh`: agent stores (store_type: :agent) represent other mesh participants; trust scores track agent reliability
- `lex-trust`: offloading trust and lex-trust domain scores are parallel; both use asymmetric decay/boost
- `lex-tick` `action_selection`: check overall_store_trust before relying on offloaded context; low trust → retrieve cautiously

## Development Notes

- `Client` instantiates `@offloading_engine = Helpers::OffloadingEngine.new`
- Trust dynamics: `TRUST_DECAY = 0.02` (failure) vs `TRUST_BOOST = 0.05` — success boosts more than failure decays (optimistic model, opposite of lex-trust's pessimistic 3:1 ratio)
- `retrieve` auto-records success; callers must call `retrieve_failed` explicitly on failure — no automatic failure detection
- `stale?` threshold is a defined constant — items that haven't been retrieved for a long period are flagged
- `RETRIEVAL_SUCCESS_THRESHOLD = 0.7` matches `DEFAULT_STORE_TRUST = 0.7` — a store starts reliable and stays reliable unless failures accumulate
