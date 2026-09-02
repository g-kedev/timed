import { click, fillIn, currentURL, visit } from "@ember/test-helpers";
import { selectChoose } from "ember-power-select/test-support";
import { setupApplicationTest, setupRenderingTest } from "ember-qunit";
import { authenticateSession } from "ember-simple-auth/test-support/index";
import { module, test } from "qunit";

import { setupMirage } from "timed/tests/helpers/mirage";

// TOOD: add following tests:
//    - when updating one duration the other should adjust (is the sum always the same?)
//    - what happens if i try to input 1000:00 in one of the durations
//    - does it send an API request with the correct data?
//    - when can we split when can't we split: when duration match -> split, when tasks and durations filled and valid -> split, when tasks and duration not filled or valid -> not splittable

module("Integration | Component | split report", function (hooks) {
  setupRenderingTest(hooks);
  setupMirage(hooks);

  // why is this.server undefined?
  hooks.beforeEach(async function () {
    const user = this.server.create("user", { isSuperuser: true });
    this.user = user;

    await authenticateSession({ user_id: user.id });

    const report = this.server.create("report");
    this.report = report;
  });
});

test("can visit /analysis/split", async function (assert) {
  await visit("/analysis/split");

  assert.strictEqual(currentURL(), "/analysis/split");
});

test("can split", async function (assert) {
  const task = this.server.create("task");

  await visit(`/analysis/split/${this.report.id}`);

  let res = {};

  await selectChoose(
    "[data-test-second-report-customer]",
    task.project.customer.name,
  );
  await selectChoose("[data-test-second-report-project]", task.project.name);
  await selectChoose("[data-test-second-report-task]", task.name);
});

test("cannot split missing required fields", async function (assert) {

});

test("cannot split unmatching reports duration", async function (assert) {
});

test("it adjusts other duration field when updating one", async function (assert) {

});

test("cannot split with invalid duration", async function (assert) {

})

test("it sends API request with correct data", async function (assert) {

});
