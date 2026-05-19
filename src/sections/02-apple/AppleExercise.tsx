// ═══════════════════════════════════════════════════════════════════
// AppleExercise — interactive 3-phase divergent thinking exercise.
// Phase 1: brainstorm 20 associations to "תפוח"
// Phase 2: pick the most surprising one
// Phase 3: design a chair inspired by that association
// All state persists in localStorage so teachers can return.
// ═══════════════════════════════════════════════════════════════════
import React, { useEffect, useMemo, useState } from 'react';
import { TbArrowLeft } from 'react-icons/tb';
import styles from './AppleExercise.module.scss';

const KEY_ASSOC = 'binai.m05.apple.associations.v1';
const KEY_PICK  = 'binai.m05.apple.pick.v1';
const KEY_CHAIR = 'binai.m05.apple.chair.v1';

type Phase = 1 | 2 | 3;

function loadStr(key: string, fallback: string): string {
  try { return localStorage.getItem(key) ?? fallback; } catch { return fallback; }
}
function saveStr(key: string, value: string): void {
  try { localStorage.setItem(key, value); } catch { /* noop */ }
}

const AppleExercise: React.FC = () => {
  const [phase, setPhase] = useState<Phase>(1);
  const [associations, setAssociations] = useState<string>(() => loadStr(KEY_ASSOC, ''));
  const [pick, setPick]   = useState<string>(() => loadStr(KEY_PICK, ''));
  const [chair, setChair] = useState<string>(() => loadStr(KEY_CHAIR, ''));

  // ── auto-save ────────────────────────────────────────────────
  useEffect(() => { saveStr(KEY_ASSOC, associations); }, [associations]);
  useEffect(() => { saveStr(KEY_PICK,  pick);         }, [pick]);
  useEffect(() => { saveStr(KEY_CHAIR, chair);        }, [chair]);

  // ── derived: parse associations into list ────────────────────
  const associationItems = useMemo(
    () => associations.split(/[\n,]/).map(s => s.trim()).filter(Boolean),
    [associations],
  );

  const canAdvanceFrom1 = associationItems.length >= 10;
  const canAdvanceFrom2 = pick.trim().length > 0;

  return (
    <section className={styles.section}>
      <div className={styles.phaseTabs} aria-label="שלב נוכחי">
        {[1, 2, 3].map(n => (
          <button
            key={n}
            type="button"
            className={[styles.tab, phase === n && styles.tabActive].filter(Boolean).join(' ')}
            onClick={() => {
              if (n === 1) setPhase(1);
              if (n === 2 && canAdvanceFrom1) setPhase(2);
              if (n === 3 && canAdvanceFrom1 && canAdvanceFrom2) setPhase(3);
            }}
            disabled={
              (n === 2 && !canAdvanceFrom1) ||
              (n === 3 && !(canAdvanceFrom1 && canAdvanceFrom2))
            }
          >
            <span className={styles.tabNum}>0{n}</span>
            <span className={styles.tabLabel}>
              {n === 1 ? 'אסוציאציות' : n === 2 ? 'בחירה' : 'כסא חדש'}
            </span>
          </button>
        ))}
      </div>

      {/* PHASE 1 — associations */}
      {phase === 1 && (
        <div className={styles.phase}>
          <h3 className={styles.phaseTitle}>20 אסוציאציות לתפוח</h3>
          <p className={styles.phaseHint}>
            כתבו כל מה שעולה. אחד מתחת לשני, או מופרד בפסיקים. אל תסננו. אל תחשבו "האם זה נכון?".
            התרגיל הוא בדיוק להתאמן בלא לסנן.
          </p>
          <textarea
            className={styles.textarea}
            value={associations}
            onChange={e => setAssociations(e.target.value)}
            placeholder="ניוטון, אדום, תפוח אדמה, יום הולדת של אבא, גן עדן, שלגיה, אייפון..."
            rows={9}
          />
          <div className={styles.phaseFooter}>
            <span className={styles.counter}>
              {associationItems.length} <em>/ 20</em>
            </span>
            <button
              type="button"
              className={styles.next}
              onClick={() => setPhase(2)}
              disabled={!canAdvanceFrom1}
            >
              <span>בחרו אחת</span>
              <TbArrowLeft aria-hidden />
            </button>
          </div>
          {!canAdvanceFrom1 && (
            <p className={styles.gateHint}>צריך לפחות 10 כדי להתקדם. אל תוותרו על אף אחת בלי לכתוב.</p>
          )}
        </div>
      )}

      {/* PHASE 2 — pick */}
      {phase === 2 && (
        <div className={styles.phase}>
          <h3 className={styles.phaseTitle}>בחרו את המפתיעה ביותר</h3>
          <p className={styles.phaseHint}>
            לא הראשונה. לא ה"נכונה". זאת שגרמה לכם להגיד "מאיפה זה בא לי?".
            לחצו עליה למטה, או הקלידו ידנית.
          </p>

          <div className={styles.assocList}>
            {associationItems.map((a, i) => (
              <button
                key={i}
                type="button"
                className={[styles.assocChip, pick === a && styles.assocChipActive].filter(Boolean).join(' ')}
                onClick={() => setPick(a)}
              >
                {a}
              </button>
            ))}
          </div>

          <input
            type="text"
            className={styles.input}
            placeholder="או כתבו ידנית..."
            value={pick}
            onChange={e => setPick(e.target.value)}
          />

          <div className={styles.phaseFooter}>
            <button type="button" className={styles.back} onClick={() => setPhase(1)}>← חזרה</button>
            <button
              type="button"
              className={styles.next}
              onClick={() => setPhase(3)}
              disabled={!canAdvanceFrom2}
            >
              <span>תכננו כסא</span>
              <TbArrowLeft aria-hidden />
            </button>
          </div>
        </div>
      )}

      {/* PHASE 3 — chair */}
      {phase === 3 && (
        <div className={styles.phase}>
          <h3 className={styles.phaseTitle}>תכננו כסא בהשראת <em>{pick || '...'}</em></h3>
          <p className={styles.phaseHint}>
            לא ציור. מילים. איך הוא נראה? איך הוא מרגיש? מי יושב עליו? מאיזה חומר?
            <strong> 4 דקות.</strong>
          </p>
          <textarea
            className={styles.textarea}
            value={chair}
            onChange={e => setChair(e.target.value)}
            placeholder="הכסא הזה..."
            rows={8}
          />
          <div className={styles.phaseFooter}>
            <button type="button" className={styles.back} onClick={() => setPhase(2)}>← חזרה</button>
            <span className={styles.done}>{chair.trim().length > 50 ? 'נראה טוב.' : ''}</span>
          </div>
        </div>
      )}
    </section>
  );
};

export default AppleExercise;